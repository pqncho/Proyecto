<template>
  <div class="counter-box">
    <span class="counter-label">Artículos publicados</span>
    <span class="counter-number">{{ articlesCount }}</span>
  </div>
</template>

<script setup>
defineProps({
  articlesCount: {
    type: Number,
    default: 0
  }
})
</script>