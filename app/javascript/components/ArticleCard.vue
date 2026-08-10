<template>

  
  <div class="article-card">

    <Link :href="`/articles/${article.id}`" class="article-card-link">
      <h3>{{ article.title }}</h3>
      <p>{{ articlePreview }}</p>
    </Link>

    <p v-if="article.user" class="article-author">
      Por {{ article.user.name }}
    </p>

    <p class="comments-count">
      {{ article.comments_count }} {{ article.comments_count === 1 ? "comentario" : "comentarios" }}
    </p>

    <button @click="darLike" class="like-button">
      {{ article.liked_by_current_user ? "❤️" : "🤍" }} {{ article.likes_count }}
    </button>

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

  </div>
</template>

<script setup>
import { computed } from "vue"
import { usePage, Link } from "@inertiajs/vue3"
import { router } from "@inertiajs/vue3"

const props = defineProps({
  article: Object
})

const page = usePage()
const auth = page.props.auth

const articlePreview = computed(() => {
  const body = props.article.body || ""
  return body.length > 150 ? body.slice(0, 150) + "..." : body
})

function darLike() {
  router.post(`/articles/${props.article.id}/toggle_like`, {}, {
    preserveScroll: true
  })
}
</script>