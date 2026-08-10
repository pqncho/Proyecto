<template>
  <div>
    <EditArticle :article="article" />
  </div>
</template>

<script setup>
import EditArticle from "../../components/EditArticle.vue"
import AppLayout from "../../layouts/AppLayout.vue"
defineOptions({ layout: AppLayout })

defineProps({
  article: Object
})
</script>