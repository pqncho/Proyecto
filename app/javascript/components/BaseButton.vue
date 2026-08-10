<template>
  <button
    :type="type"
    @click="$emit('click')"
  >
    <slot />
  </button>
</template>


<script setup>

defineProps({
  type: {
    type: String,
    default: "button"
  }
})


defineEmits([
  "click"
])

</script>