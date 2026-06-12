<script lang="ts">
  import data from '$store/data';
  import { cn } from '$utils/misc';
  import Icon from '@iconify/svelte';
  import * as Tooltip from './lib/tooltip';
</script>

{#if $data.statusIndicators}
  <div class="flex select-none flex-wrap items-center justify-center gap-3">
    {#each $data.statusIndicators as item}
      <Tooltip.Root openDelay={250} closeOnPointerDown={false} disableHoverableContent={true}>
        <Tooltip.Trigger>
          <div
            class={cn(
              'rounded-full p-2.5 transition-all duration-300 border',
              item.state
                ? 'bg-primary/25 text-primary border-primary/40 hover:bg-primary/35 hover:scale-110'
                : 'bg-destructive/25 text-destructive border-destructive/40 hover:bg-destructive/35 hover:scale-110'
            )}
          >
            <Icon icon={item.icon} class="h-5 w-5" />
          </div>
        </Tooltip.Trigger>
        <Tooltip.Content>
          <p>{item.label}</p>
        </Tooltip.Content>
      </Tooltip.Root>
    {/each}
  </div>
{/if}
