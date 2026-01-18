<template>
  <div class="min-h-screen bg-[#0a0f0a] text-[#e8ebe4]">
    <!-- Background -->
    <div class="fixed inset-0 z-0">
      <div class="absolute inset-0 bg-gradient-to-b from-[#0a1510] via-[#0a0f0a] to-[#0f1a15]" />
    </div>

    <!-- Main content -->
    <div class="relative z-10 min-h-screen flex flex-col items-center justify-center px-6 py-12">
      <!-- Logo -->
      <img
        src="/img/logo.svg"
        alt="Avalon"
        class="w-20 h-20 rounded-full border border-[#5a8a7a]/30 mb-6"
      />

      <!-- Title -->
      <h1
        class="text-3xl md:text-4xl tracking-[0.1em] mb-3 text-center"
        style="font-family: 'Cinzel', serif"
      >
        {{ appName.toUpperCase() }}
      </h1>

      <p class="text-[#9aaa9a] mb-8 text-center" style="font-family: 'Cormorant Garamond', serif">
        Form Builder
      </p>

      <!-- Auth buttons -->
      <div class="flex gap-4">
        <UButton
          v-if="!authenticated"
          :to="{ name: 'login' }"
          size="lg"
          class="btn-avalon px-8 py-3"
        >
          Sign In
        </UButton>
        <UButton
          v-else
          :to="{ name: 'home' }"
          size="lg"
          class="btn-avalon px-8 py-3"
        >
          Dashboard
        </UButton>
      </div>
    </div>

    <open-form-footer />
  </div>
</template>

<script setup>
import { useIsAuthenticated } from '~/composables/useAuthFlow'
import { computed } from 'vue'
import opnformConfig from "~/opnform.config.js"
import { useOpnSeoMeta } from '~/composables/useOpnSeoMeta'
import { definePageMeta } from '#imports'

definePageMeta({
  layout: 'default'
})

const { isAuthenticated: authenticated } = useIsAuthenticated()
const appName = computed(() => opnformConfig.app_name || 'Avalon')

useOpnSeoMeta({
  title: `${appName.value} Forms`,
  description: "Avalon form builder for creators."
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;500&family=Cormorant+Garamond:wght@400;500&display=swap');

.btn-avalon {
  background: rgba(20, 35, 30, 0.8) !important;
  border: 1px solid rgba(90, 138, 122, 0.3) !important;
  color: #e8ebe4 !important;
  font-family: 'Cormorant Garamond', serif;
  letter-spacing: 0.05em;
  transition: all 0.3s ease;
}

.btn-avalon:hover {
  background: rgba(30, 50, 40, 0.9) !important;
  border-color: rgba(90, 138, 122, 0.5) !important;
  box-shadow: 0 0 20px 4px rgba(90, 138, 122, 0.2);
}
</style>
