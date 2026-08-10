<template>
  <div>
    <Admin :users="users" />
  </div>
</template>

<script setup>
import Admin from "../../components/Admin.vue"
import AppLayout from "../../layouts/AppLayout.vue"
defineOptions({ layout: AppLayout })

defineProps({
  users: Array
})
</script>