<template>

  <input
    :type="type"
    :placeholder="placeholder"
    :value="modelValue"
    @input="$emit('update:modelValue', $event.target.value)"
  >

</template>


<script setup>

defineProps({
  modelValue: String,
  placeholder: String,
  type: {
    type: String,
    default: "text"
  }
})


defineEmits([
  "update:modelValue"
])

</script>