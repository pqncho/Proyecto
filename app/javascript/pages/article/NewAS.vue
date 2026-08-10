<template>
  <div>
    <ArticleDetail :article="article" />
  </div>
</template>

<script setup>
import ArticleDetail from '../../components/ArticleDetail.vue'
import AppLayout from '../../layouts/AppLayout.vue'

defineOptions({ layout: AppLayout })

defineProps({
  article: Object
})
</script>