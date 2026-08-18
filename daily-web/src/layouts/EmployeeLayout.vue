<template>
  <div class="employee-layout">
    <header class="employee-header">
      <div>
        <span class="eyebrow">DAILY REPORT</span>
        <strong>每日工作日报</strong>
      </div>
      <nav aria-label="日报导航">
        <RouterLink to="/report">填写今日日报</RouterLink>
        <RouterLink to="/my-report">修改已提交日报</RouterLink>
      </nav>
    </header>
    <main class="employee-content"><slot /></main>
  </div>
</template>
