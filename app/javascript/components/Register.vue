<template>
  <div class="auth-box">
    <h2>Crear cuenta</h2>

    <BaseInput v-model="form.user.name" placeholder="Nombre" class="form-input" />
<BaseInput v-model="form.user.email" placeholder="Email" class="form-input" />
<BaseInput v-model="form.user.password" type="password" placeholder="Contraseña" class="form-input" />
<BaseInput v-model="form.user.password_confirmation" type="password" placeholder="Confirmar contraseña" class="form-input" />

    <BaseButton @click="register" class="form-button" :disabled="form.processing">
      Registrarse
    </BaseButton>

    <div v-if="Object.keys(form.errors).length">
      <p v-for="(msg, field) in form.errors" :key="field" style="color: #b91c1c;">
        {{ msg }}
      </p>
    </div>
  </div>
</template>

<script setup>
import BaseInput from "./BaseInput.vue"
import BaseButton from "./BaseButton.vue"
import { useForm } from "@inertiajs/vue3"

const form = useForm({
  user: {
    name: "",
    email: "",
    password: "",
    password_confirmation: "",
  }
})

function register() {
  form.post("/register", {
    onSuccess: () => form.reset(),
  })
}
</script>