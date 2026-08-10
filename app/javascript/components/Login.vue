<template>
  <div class="auth-box">
    <h2>Inicio de sesión</h2>

    <BaseInput v-model="form.email" placeholder="Email" class="form-input" />
    <BaseInput v-model="form.password" type="password" placeholder="Contraseña" class="form-input" />

    <BaseButton @click="login" class="form-button" :disabled="form.processing">
      Iniciar sesión
    </BaseButton>

    <p v-if="form.errors.base" style="color: #b91c1c; margin-top: 10px;">
      {{ form.errors.base }}
    </p>
  </div>
</template>

<script setup>
import BaseInput from "./BaseInput.vue"
import BaseButton from "./BaseButton.vue"
import { useForm } from "@inertiajs/vue3"

const form = useForm({
  email: "",
  password: "",
})

function login() {
  form.post("/login", {
    onSuccess: () => form.reset(),
  })
}
</script>