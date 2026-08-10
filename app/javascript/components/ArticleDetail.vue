<template>
  <div class="article-card">

    <h3>{{ article.title }}</h3>
    <p>{{ article.body }}</p>
    <div v-if="article.image_urls && article.image_urls.length" class="article-images">
  <img
    v-for="(url, index) in article.image_urls"
    :key="index"
    :src="url"
    alt="Imagen del artículo"
    class="article-image"
  />
</div>

    <p v-if="article.user" class="article-author">
      Por {{ article.user.name }}
    </p>

    <!-- NUEVO: botón de like -->
    <button @click="darLike" class="like-button">
      {{ article.liked_by_current_user ? "❤️" : "🤍" }} {{ article.likes_count }}
    </button>

    <!-- NUEVO: lista de quién dio like -->
    <div v-if="article.likes && article.likes.length" class="likes-list">
      
          <p v-if="article.likes && article.likes.length" class="likes-list">
      Dieron like a este articulo: {{ article.likes.map(l => l.user.name).join(", ") }}
    </p>
    </div>
    <p v-else class="no-likes">Todavía nadie le dio like.</p>

    <div class="article-actions" v-if="auth.user && article.user && auth.user.id === article.user.id">
      <Link :href="`/articles/${article.id}/edit`" class="action-link edit-link">Editar</Link>
      <Link
        :href="`/articles/${article.id}`"
        method="delete"
        as="button"
        class="action-link destroy-button"
      >
        Eliminar
      </Link>
    </div>

    <hr>

    <h4>Comentarios</h4>

    <div v-if="article.comments && article.comments.length">
      <div
        v-for="comment in article.comments"
        :key="comment.id"
        class="comment"
      >
        <strong>{{ comment.user.name }}</strong>
        <p>{{ comment.content }}</p>

        <button
          v-if="auth.user && (auth.user.id === comment.user.id || auth.user.id === article.user.id)"
          @click="eliminarComentario(comment.id)"
          class="action-link destroy-button"
        >
          Eliminar
        </button>
      </div>
    </div>
    <p v-else class="no-comments">Todavía no hay comentarios.</p>

    <BaseButton class="form-button"
      v-if="auth.user"
      @click="mostrarFormulario = !mostrarFormulario"
    >
      {{ mostrarFormulario ? "Cancelar" : "Comentar" }}
    </BaseButton>

    <p v-else class="login-required">
      Tenés que iniciar sesión para comentar.
    </p>

    <div v-if="mostrarFormulario">
      <NewComment :article-id="article.id" />
    </div>

  </div>
</template>

<script setup>
import { ref } from "vue"
import { usePage, Link, router } from "@inertiajs/vue3"
import BaseButton from "./BaseButton.vue"
import NewComment from "./NewComment.vue"

const props = defineProps({
  article: Object
})

const page = usePage()
const auth = page.props.auth

const mostrarFormulario = ref(false)

// NUEVO: función para dar/sacar like
function darLike() {
  router.post(`/articles/${props.article.id}/toggle_like`, {}, {
    preserveScroll: true
  })
}

function eliminarComentario(commentId) {
  const confirmado = confirm("¿Eliminar este comentario?")
  if (!confirmado) return

  router.delete(`/articles/${props.article.id}/comments/${commentId}`, {
    preserveScroll: true
  })
}
</script>