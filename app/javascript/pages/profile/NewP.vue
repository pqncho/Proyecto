<template>
  <div>
    <Head title="Mi perfil" />
    <Profile :user="user" :articles="articles" />
  </div>
</template>

<script setup>
import { Head } from "@inertiajs/vue3"
import Profile from "../../components/Profile.vue"
import AppLayout from "../../layouts/AppLayout.vue"
defineOptions({ layout: AppLayout })

defineProps({
  user: Object,
  articles: Array
})
</script>