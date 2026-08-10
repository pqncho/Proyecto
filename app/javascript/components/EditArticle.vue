<template>
  <div class="article-form">
    <h2>Editar artículo</h2>

    <p v-if="page.props.flash?.notice" class="success-message">{{ page.props.flash.notice }}</p>

    <div class="form-group">
      <label>Título</label>
      <BaseInput v-model="form.title" placeholder="Título" class="form-input" />
    </div>

    <div class="form-group">
      <label>Contenido</label>
      <textarea v-model="form.body" class="form-textarea"></textarea>
    </div>

    <BaseButton @click="guardar" class="form-button" :disabled="form.processing">
      {{ form.processing ? "Guardando..." : "Guardar cambios" }}
    </BaseButton>

    <div v-if="Object.keys(form.errors).length">
      <p v-for="(msg, field) in form.errors" :key="field" style="color: #b91c1c; margin-top: 10px;">
        {{ msg }}
      </p>
    </div>
  </div>
</template>

<script setup>
import { useForm, usePage } from "@inertiajs/vue3"
import BaseInput from "./BaseInput.vue"
import BaseButton from "./BaseButton.vue"

const props = defineProps({
  article: Object
})

const page = usePage()

const form = useForm({
  title: props.article.title,
  body: props.article.body
})

function guardar() {
  form.patch(`/articles/${props.article.id}`, {
    preserveScroll: true,
  })
}
</script>