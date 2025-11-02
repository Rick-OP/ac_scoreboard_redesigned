<script lang="ts">
  import data from '$store/data';
  import locales from '$store/locales';
  import { fetchNui } from '$utils/fetchNui';
  import { cn } from '$utils/misc';
  import Icon, { loadIcons } from '@iconify/svelte';
  import * as Tooltip from './lib/tooltip';

  let hasCopied = false;

  const copyServerId = () => {
    fetchNui('copyServerId');
    hasCopied = true;
    setTimeout(() => (hasCopied = false), 4000);
  };

  const copyIcons = {
    copy: 'mdi:cursor-default-click',
    copied: 'mdi:clipboard-check',
  };

  // preload icons to prevent possible "flash" of empty icon space before it loads
  // since it's visible only on hover, it's quite noticeable
  loadIcons([copyIcons.copy, copyIcons.copied]);
</script>

{#if $data.footer}
  <div class="flex select-none flex-wrap items-center justify-center gap-3 border-t border-border/50 pt-5">
    <Tooltip.Root openDelay={250} closeOnPointerDown={false} disableHoverableContent={true}>
      <Tooltip.Trigger>
        <button
          onclick={copyServerId}
          class="flex h-9 items-center gap-2.5 rounded-xl bg-card border border-border/50 px-4 transition-all duration-300 hover:border-primary/60 hover:-translate-y-0.5"
        >
          <Icon icon="mingcute:user-2-fill" class="h-4 w-4 text-primary" />
          <span class="text-sm font-semibold">{$data.footer.serverId}</span>
        </button>
      </Tooltip.Trigger>
      <Tooltip.Content class={cn(hasCopied && 'bg-primary border-primary')}>
        <div class="flex items-center gap-1.5">
          <Icon icon={hasCopied ? copyIcons.copied : copyIcons.copy} class="h-4 w-4" />
          <p>{hasCopied ? $locales.server_id_copied : $locales.copy_server_id}</p>
        </div>
      </Tooltip.Content>
    </Tooltip.Root>

    <div class="flex h-9 items-center gap-2.5 rounded-xl bg-card border border-border/50 px-4">
      <Icon icon="mingcute:group-fill" class="h-4 w-4 text-primary" />
      <span class="text-sm font-semibold">
        {$data.footer.playerCount}/{$data.footer.maxPlayers}
      </span>
    </div>
  </div>
{/if}
