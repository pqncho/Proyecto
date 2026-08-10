<template>
  <Head title="Iniciar sesión" />
  <Login />
</template>

<script setup>
import { Head } from "@inertiajs/vue3"
import Login from "../../components/Login.vue"
import AppLayout from "../../layouts/AppLayout.vue"
defineOptions({ layout: AppLayout })
</script>