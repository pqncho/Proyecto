<template>
  <div>
    <NewArticle />
  </div>
</template>

<script setup>
import NewArticle from "../../components/NewArticle.vue"
import AppLayout from "../../layouts/AppLayout.vue"
defineOptions({ layout: AppLayout })
</script>