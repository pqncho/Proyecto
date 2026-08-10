<template>
  <div>
    <p v-if="user">
      Hola {{ user.name }}
    </p>

    <p v-else>
      No hay usuario logueado
    </p>
  </div>
</template>


<script setup>
import { ref, onMounted } from "vue"

const user = ref(null)


async function cargarUsuario() {

  try {

    const response = await fetch("/api/v1/users/profile")

    const data = await response.json()

    user.value = data

  } catch(error) {

    console.error("Error cargando usuario", error)

  }

}


onMounted(() => {
  cargarUsuario()
})
</script>