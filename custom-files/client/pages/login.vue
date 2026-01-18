<template>
  <div class="min-h-screen bg-[#0a0f0a] text-[#e8ebe4]">
    <!-- Background -->
    <div class="fixed inset-0 z-0">
      <div class="absolute inset-0 bg-gradient-to-b from-[#0a1510] via-[#0a0f0a] to-[#0f1a15]" />
    </div>

    <!-- Main Content -->
    <div class="relative z-10 flex mt-6 mb-10 min-h-screen">
      <div class="w-full mx-auto px-4 flex md:flex-row-reverse flex-wrap items-center">
        <!-- Form Section -->
        <div class="w-full md:w-1/2 md:p-6">
          <div class="login-card border border-[#5a8a7a]/20 rounded-md p-6 shadow-md sticky top-4">
            <!-- Logo -->
            <div class="flex justify-center mb-4">
              <img
                src="/img/logo.svg"
                alt="Avalon"
                class="w-12 h-12 rounded-full border border-[#5a8a7a]/30"
              />
            </div>

            <h2
              class="text-2xl text-center mb-1"
              style="font-family: 'Cinzel', serif"
            >
              Login to {{ appName }}
            </h2>
            <p class="text-sm text-[#9aaa9a] text-center mb-6" style="font-family: 'Cormorant Garamond', serif">
              Welcome back. Enter your details to continue.
            </p>

            <login-form class="avalon-form" />
          </div>
        </div>

        <!-- Left Section -->
        <div class="w-full md:w-1/2 md:p-6 mt-8 md:mt-0 text-center md:text-left">
          <h1
            class="text-3xl md:text-4xl mb-4 tracking-[0.1em]"
            style="font-family: 'Cinzel', serif"
          >
            {{ appName.toUpperCase() }}
          </h1>
          <p class="text-[#9aaa9a] text-lg" style="font-family: 'Cormorant Garamond', serif">
            Form builder for Avalon creators.
          </p>
        </div>
      </div>
    </div>

    <open-form-footer />
  </div>
</template>

<script setup>
import { useOpnSeoMeta } from '~/composables/useOpnSeoMeta'
import LoginForm from "~/components/pages/auth/components/LoginForm.vue"
import opnformConfig from "~/opnform.config.js"

definePageMeta({
  layout: 'default',
  middleware: "guest"
})

const appName = computed(() => opnformConfig.app_name || 'Avalon')

useOpnSeoMeta({
  title: `Login | ${appName.value}`,
  description: "Sign in to Avalon Forms."
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;500&family=Cormorant+Garamond:wght@400;500&display=swap');

.login-card {
  background: rgba(15, 25, 20, 0.9);
}

/* Form overrides */
.avalon-form :deep(input),
.avalon-form :deep(select),
.avalon-form :deep(textarea) {
  background: rgba(15, 25, 20, 0.6) !important;
  border: 1px solid rgba(90, 138, 122, 0.25) !important;
  color: #e8ebe4 !important;
}

.avalon-form :deep(input:focus),
.avalon-form :deep(select:focus),
.avalon-form :deep(textarea:focus) {
  border-color: rgba(90, 138, 122, 0.5) !important;
  box-shadow: 0 0 10px 2px rgba(90, 138, 122, 0.15) !important;
  outline: none !important;
}

.avalon-form :deep(input::placeholder) {
  color: rgba(154, 170, 154, 0.6) !important;
}

.avalon-form :deep(label) {
  color: #b8c4b8 !important;
}

.avalon-form :deep(button[type="submit"]),
.avalon-form :deep(.btn-primary) {
  background: rgba(20, 35, 30, 0.8) !important;
  border: 1px solid rgba(90, 138, 122, 0.3) !important;
  color: #e8ebe4 !important;
  transition: all 0.3s ease !important;
}

.avalon-form :deep(button[type="submit"]:hover),
.avalon-form :deep(.btn-primary:hover) {
  background: rgba(30, 50, 40, 0.9) !important;
  border-color: rgba(90, 138, 122, 0.5) !important;
  box-shadow: 0 0 20px 4px rgba(90, 138, 122, 0.2) !important;
}

.avalon-form :deep(a) {
  color: #7ab8a8 !important;
}

.avalon-form :deep(a:hover) {
  color: #9ad8c8 !important;
}

.avalon-form :deep(.text-gray-500),
.avalon-form :deep(.text-neutral-500) {
  color: #9aaa9a !important;
}
</style>
