<template>
  <Head title="Crear cuenta" />
  <Register />
</template>

<script setup>
import { Head } from "@inertiajs/vue3"
import Register from "../../components/Register.vue"
import AppLayout from "../../layouts/AppLayout.vue"
defineOptions({ layout: AppLayout })
</script>