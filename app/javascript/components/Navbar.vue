<template>
  <nav class="navbar">
    <Link href="/" class="navbar-brand">Pagina Principal</Link>

    <div class="navbar-actions">
      <template v-if="user">
        <Link href="/profile" class="navbar-button">Mi perfil</Link>
        <Link v-if="user.admin" href="/admin/users" class="navbar-button">Admin</Link>
        <Link href="/articles/new" class="navbar-button navbar-button-primary">
          Crear artículo
        </Link>
        <button @click="logout" class="navbar-button navbar-button-logout">
          Cerrar sesión
        </button>
      </template>

      <template v-else>
        <Link href="/login" class="navbar-button">Iniciar sesión</Link>
        <Link href="/register" class="navbar-button navbar-button-primary">Registrarse</Link>
      </template>
    </div>
  </nav>
</template>

<script setup>
import { computed } from "vue"
import { Link, usePage, router } from "@inertiajs/vue3"

const page = usePage()
const user = computed(() => page.props.auth.user)

function logout() {
  router.delete("/logout")
}
</script>