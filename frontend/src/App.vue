<script setup>
import { ref, onMounted } from "vue";

const items = ref([]);

onMounted(async () => {
  const res = await fetch("http://localhost:8081/api/items");
  items.value = await res.json();
  console.log(items);
});
</script>

<template>
  <div>
    <h1>Item List</h1>
    <ul>
      <li v-for="item in items" :key="item.id">{{ item.name }}</li>
    </ul>
  </div>
</template>
