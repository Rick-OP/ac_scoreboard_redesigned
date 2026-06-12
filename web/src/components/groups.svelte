<script lang="ts">
  import Icon from '@iconify/svelte';
  import data from '$store/data';
  import config from '$store/config';
  import locales from '$store/locales';
  import { cn } from '$utils/misc';
</script>

{#if $data.groups}
  <div>
    <div class="mb-4 select-none text-xs font-bold uppercase tracking-widest text-muted-foreground">
      {$locales.groups}
    </div>

    <div class={cn('grid gap-2.5', $config.groupColumns === 1 ? 'grid-cols-1' : 'grid-cols-2')}>
      {#each $data.groups as group (group)}
        <div
          class={cn(
            'group flex items-center justify-between gap-2 rounded-xl bg-card border border-border/50 px-3.5 transition-all duration-300 hover:border-primary/60 hover:-translate-y-0.5',
            $config.compactGroups ? 'py-2.5' : 'py-3'
          )}
        >
          <div class="flex items-center gap-2.5 truncate">
            {#if group.icon}
              <Icon icon={group.icon} class="h-5 min-w-5 text-primary" />
            {/if}
            <span class="truncate text-sm font-semibold text-foreground/90">{group.label}</span>
          </div>
          {#if group.count !== undefined}
            <span
              class={cn(
                'min-w-9 flex-shrink-0 select-none rounded-lg px-2.5 py-1 text-xs font-bold text-center border',
                $config.highlightEmptyGroups && group.count === 0
                  ? 'bg-destructive/25 text-destructive border-destructive/30'
                  : 'bg-primary/25 text-primary border-primary/30'
              )}>{group.count}</span
            >
          {/if}
        </div>
      {/each}
    </div>
  </div>
{/if}
