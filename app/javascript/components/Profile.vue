<template>
  <div>
    <h2>Mi perfil</h2>

    <div class="profile-info">
      <template v-if="!editando">
        <p v-if="page.props.flash?.notice" class="success-message">{{ page.props.flash.notice }}</p>
        <p>Nombre: {{ user.name }}</p>
        <p>Email: {{ user.email }}</p>
        <BaseButton @click="editando = true" class="edit-link action-link">
          Editar perfil
        </BaseButton>
      </template>

      <template v-else>
        <div class="form-group">
          <label>Nombre</label>
          <BaseInput v-model="form.user.name" placeholder="Nombre" class="form-input" />
        </div>

        <div class="form-group">
          <label>Email</label>
          <BaseInput v-model="form.user.email" placeholder="Email" class="form-input" />
        </div>

        <div class="form-group">
          <label>Nueva contraseña (dejar vacío para no cambiarla)</label>
          <BaseInput v-model="form.user.password" type="password" placeholder="Nueva contraseña" class="form-input" />
        </div>

        <div class="form-group">
          <label>Confirmar nueva contraseña</label>
          <BaseInput v-model="form.user.password_confirmation" type="password" placeholder="Confirmar contraseña" class="form-input" />
        </div>

        <div v-if="Object.keys(form.errors).length">
          <p v-for="(msg, field) in form.errors" :key="field" style="color: #b91c1c;">
            {{ msg }}
          </p>
        </div>

        <div class="profile-article-actions">
          <BaseButton @click="guardarPerfil" class="form-button" :disabled="form.processing">
            {{ form.processing ? "Guardando..." : "Guardar cambios" }}
          </BaseButton>
          <BaseButton @click="cancelarEdicion" class="back-link action-link">Cancelar</BaseButton>
        </div>
      </template>
    </div>

    <h3>Mis artículos</h3>

    <p v-if="articles.length === 0" class="loading-text">Todavía no publicaste ningún artículo.</p>

    <div
      v-for="article in articles"
      :key="article.id"
      class="profile-article"
    >
      <h4>{{ article.title }}</h4>
      <p>{{ article.body }}</p>

      <div class="profile-article-actions">
        <Link :href="`/articles/${article.id}/edit`" class="edit-link action-link">
          Editar
        </Link>

        <BaseButton @click="eliminarArticulo(article.id)" class="destroy-button action-link">
          Eliminar
        </BaseButton>
      </div>
    </div>
  </div>
</template>

<script setup>
import BaseButton from "./BaseButton.vue"
import BaseInput from "./BaseInput.vue"
import { ref, watch } from "vue"
import { useForm, usePage, router, Link } from "@inertiajs/vue3"

const props = defineProps({
  user: Object,
  articles: Array
})

const page = usePage()

// si el server nos manda errores (ej: password_confirmation no coincide),
// arrancamos directamente en modo edición para poder mostrarlos
const editando = ref(Object.keys(page.props.errors || {}).length > 0)

const form = useForm({
  user: {
    name: props.user.name,
    email: props.user.email,
    password: "",
    password_confirmation: ""
  }
})

// por si Inertia reutiliza el componente sin remontarlo (navegación entre páginas del mismo componente)
watch(() => page.props.errors, (errors) => {
  if (errors && Object.keys(errors).length > 0) {
    editando.value = true
    form.errors = errors
  }
})

function cancelarEdicion() {
  editando.value = false
  form.reset()
  form.clearErrors()
}

function guardarPerfil() {
  form.patch("/profile", {
    preserveScroll: true,
    onSuccess: () => {
      editando.value = false
      form.user.password = ""
      form.user.password_confirmation = ""
    }
  })
}

function eliminarArticulo(id) {
  const confirmado = confirm("¿Seguro que querés eliminar este artículo? Esta acción no se puede deshacer.")
  if (!confirmado) return

  router.delete(`/articles/${id}`, { preserveScroll: true })
}
</script>