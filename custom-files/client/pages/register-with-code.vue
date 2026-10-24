<script setup>
// The access-code page is /register now; old links to this page land there.
definePageMeta({ middleware: [() => navigateTo("/register", { redirectCode: 301 })] })
</script>

<template>
  <div />
</template>
