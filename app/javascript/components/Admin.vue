<template>
  <div>
    <h2>Panel de administración</h2>

    <p v-if="page.props.flash?.alert" style="color: #b91c1c;">{{ page.props.flash.alert }}</p>
    <p v-if="page.props.flash?.notice" class="success-message">{{ page.props.flash.notice }}</p>

    <div class="admin-table-wrapper">
      <table class="admin-table">
        <thead>
          <tr>
            <th>Nombre</th>
            <th>Email</th>
            <th>Admin</th>
            <th>Registrado</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="u in users" :key="u.id">
            <td>{{ u.name }}</td>
            <td>{{ u.email }}</td>
            <td>{{ u.admin ? "Sí" : "No" }}</td>
            <td>{{ formatearFecha(u.created_at) }}</td>
            <td>
              <BaseButton @click="eliminarUsuario(u.id)" class="destroy-button action-link">
                Eliminar
              </BaseButton>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<script setup>
import BaseButton from "./BaseButton.vue"
import { usePage, router } from "@inertiajs/vue3"

defineProps({
  users: Array
})

const page = usePage()

function formatearFecha(fecha) {
  return new Date(fecha).toLocaleDateString()
}

function eliminarUsuario(id) {
  const confirmado = confirm("¿Seguro que querés eliminar este usuario? Esta acción no se puede deshacer.")
  if (!confirmado) return

  router.delete(`/admin/users/${id}`)
}
</script>