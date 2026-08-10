<template>
  <div>
    <h2>Artículos</h2>

    <p v-if="cargando" class="loading-text">Cargando artículos...</p>

    <div v-else class="articles-grid">
      <ArticleCard
        v-for="article in articles"
        :key="article.id"
        :article="article"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue"
import ArticleCard from "./ArticleCard.vue"

const articles = ref([])
const cargando = ref(true)

async function cargarArticulos() {
  try {
    const response = await fetch("/api/v1/articles")
    const data = await response.json()

    articles.value = data

  } catch (error) {
    console.error("Error al cargar los artículos", error)
  } finally {
    cargando.value = false
  }
}

onMounted(() => {
  cargarArticulos()
})
</script>