<template>
  <div class="new-comment">
    <BaseInput
      v-model="form.content"
      placeholder="Escribe un comentario..."
      class="form-input"
    />

    <BaseButton @click="crearComentario" class="form-button" :disabled="form.processing">
      Publicar
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

const props = defineProps({
  articleId: Number
})

const form = useForm({
  content: ""
})

function crearComentario() {
  if (!form.content.trim()) return

  form.post(`/articles/${props.articleId}/comments`, {
    preserveScroll: true,
    onSuccess: () => form.reset(),
  })
}
</script>