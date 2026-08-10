<template>
  <div>
    <h2>Artículos</h2>

    <div class="articles-grid">
      <ArticleCard
        v-for="article in articles"
        :key="article.id"
        :article="article"
      />
    </div>

    <Counter :articles-count="articlesCount" />
  </div>
</template>

<script setup>
import { usePage } from '@inertiajs/vue3'
import ArticleCard from '../../components/ArticleCard.vue'
import Counter from '../../components/Counter.vue'
import AppLayout from '../../layouts/AppLayout.vue'

defineOptions({ layout: AppLayout })

defineProps({
  articles: {
    type: Array,
    default: () => []
  },
  articlesCount: {
    type: Number,
    default: 0
  }
})

const page = usePage()
const auth = page.props.auth
</script>