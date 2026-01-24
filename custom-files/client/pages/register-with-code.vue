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
              class="text-2xl text-center mb-1 text-[#e8ebe4]"
              style="font-family: 'Cinzel', serif"
            >
              Create an account
            </h2>
            <p class="text-sm text-[#9aaa9a] text-center mb-6" style="font-family: 'Cormorant Garamond', serif">
              Enter the access code to continue.
            </p>

            <!-- Access Code Check -->
            <div v-if="!accessGranted" class="avalon-form">
              <div class="mb-4">
                <label class="block text-sm mb-2 text-[#b8c4b8]">Access Code</label>
                <input
                  v-model="accessCode"
                  type="text"
                  placeholder="Enter access code"
                  class="w-full px-4 py-2 rounded-md"
                  style="background: rgba(15, 25, 20, 0.6); border: 1px solid rgba(90, 138, 122, 0.25); color: #e8ebe4;"
                  @keyup.enter="checkAccessCode"
                />
              </div>
              <UButton
                block
                size="lg"
                @click="checkAccessCode"
                class="btn-avalon"
              >
                Continue
              </UButton>
              <p v-if="codeError" class="text-red-400 text-sm mt-2 text-center">
                Invalid access code. Please try again.
              </p>
            </div>

            <!-- Registration Form (shown after correct code) -->
            <register-form v-else class="avalon-form" />
          </div>
        </div>

        <!-- Left Section -->
        <div class="w-full md:w-1/2 md:p-6 mt-8 md:mt-0 text-center md:text-left">
          <h1
            class="text-3xl md:text-4xl mb-4 tracking-[0.1em] text-[#e8ebe4]"
            style="font-family: 'Cinzel', serif"
          >
            {{ appName.toUpperCase() }}
          </h1>
          <p class="text-[#9aaa9a] text-lg" style="font-family: 'Cormorant Garamond', serif">
            Create beautiful forms and share them anywhere.
          </p>
        </div>
      </div>
    </div>

    <open-form-footer />
  </div>
</template>

<script setup>
import { useOpnSeoMeta } from '~/composables/useOpnSeoMeta'
import RegisterForm from "~/components/pages/auth/components/RegisterForm.vue"
import opnformConfig from "~/opnform.config.js"

definePageMeta({
  layout: 'default',
  middleware: "guest"
})

const appName = computed(() => opnformConfig.app_name || 'Avalon')

useOpnSeoMeta({
  title: `Register | ${appName.value}`,
  description: "Create your Avalon Forms account."
})

// Access code logic
const accessCode = ref('')
const accessGranted = ref(false)
const codeError = ref(false)

// CHANGE THIS to your secret code
const VALID_CODE = 'avalon2026'

const checkAccessCode = () => {
  if (accessCode.value.trim().toLowerCase() === VALID_CODE.toLowerCase()) {
    accessGranted.value = true
    codeError.value = false
  } else {
    codeError.value = true
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Cinzel:wght@400;500&family=Cormorant+Garamond:wght@400;500&display=swap');

.login-card {
  background: rgba(15, 25, 20, 0.9);
}

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
