<template>
  <div>
    <h2>Crear artículo</h2>

    <BaseInput
      v-model="form.title"
      placeholder="Título"
      class="form-input"
    />

    <textarea
      v-model="form.body"
      placeholder="Contenido"
      class="form-input"
    ></textarea>

    <div class="file-upload">
      <label for="images" class="file-upload-label">
        📷 Seleccionar imágenes
      </label>
      <input
        id="images"
        type="file"
        multiple
        accept="image/*"
        @change="onFileChange"
        class="file-upload-input"
      />

      <p v-if="form.images.length" class="file-upload-filenames">
        {{ form.images.length }} {{ form.images.length === 1 ? "archivo seleccionado" : "archivos seleccionados" }}:
        {{ form.images.map(f => f.name).join(", ") }}
      </p>
      <p v-else class="file-upload-empty">
        Todavía no se ha seleccionado ningún archivo.
      </p>
    </div>

    <BaseButton @click="crearArticulo" class="form-button" :disabled="form.processing">
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

const form = useForm({
  title: "",
  body: "",
  images: []
})

function onFileChange(event) {
  form.images = Array.from(event.target.files)
}

function crearArticulo() {
  form.post("/articles", {
    forceFormData: true,
    onSuccess: () => form.reset(),
  })
}
</script>