<script lang="ts">
  import config from '$store/config';

  const handleMissingImage = () => {
    $config.title.logo = './logo.png';
  };
</script>

<div class="flex h-12 select-none items-center gap-3 border-b border-border/50 pb-4 mb-1">
  {#if $config.title.logo !== false}
    <img
      class="h-full rounded-lg"
      style="color-scheme:dark;"
      src={$config.title.logo ?? 'defaultTitleLogo'}
      alt="Server logo"
      onerror={handleMissingImage}
    />
  {/if}
  {#if $config.title.text !== false}
    <p class="text-2xl font-bold bg-gradient-to-r from-foreground via-foreground to-[#098bfd] bg-clip-text text-transparent">
      {$config.title.text ?? 'AC Scoreboard'}
    </p>
  {/if}
</div>
