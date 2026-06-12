<script lang="ts">
  import data from '$store/data';
  import config from '$store/config';
  import locales from '$store/locales';
  import { cn } from '$utils/misc';
  import Icon from '@iconify/svelte';

  let searchQuery = $state('');

  function filterPlayers() {
    if (!searchQuery.trim() || !$data.players) {
      return $data.players || [];
    }

    const query = searchQuery.toLowerCase().trim();

    return $data.players.filter((player) => {
      const nameMatch = player.name?.toLowerCase().includes(query);
      const idMatch = player.id?.toString().includes(query);
      return nameMatch || idMatch;
    });
  }
</script>

{#if $data.players}
  <div>
    <div class="mb-4 flex items-center justify-between gap-3">
      <div class="select-none text-xs font-bold uppercase tracking-widest text-muted-foreground">
        {$locales.players}
      </div>
      <div class="relative flex-1 max-w-xs">
        <Icon icon="mdi:magnify" class="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
        <input
          type="text"
          bind:value={searchQuery}
          placeholder="Search by ID or name..."
          class="w-full rounded-lg bg-card border border-border/50 pl-9 pr-3 py-1.5 text-sm text-foreground placeholder:text-muted-foreground focus:border-primary/60 focus:outline-none transition-colors"
        />
      </div>
    </div>

    <div class={cn('grid gap-2.5', $config.playerColumns === 1 ? 'grid-cols-1' : 'grid-cols-2')}>
      {#each filterPlayers() as player (player)}
        <div
          class={cn(
            'group flex items-center gap-3 rounded-xl bg-card border border-border/50 px-3.5 transition-all duration-300 hover:border-primary/60 hover:-translate-y-0.5',
            $config.uppercaseNames && 'uppercase',
            $config.compactPlayers ? 'py-2.5' : 'py-3'
          )}
        >
          {#if player.id !== undefined}
            <span class="flex-shrink-0 w-12 select-none rounded-md bg-secondary/60 text-muted-foreground px-2 py-0.5 text-[10px] font-bold text-center border border-border/50">
              #{player.id}
            </span>
          {/if}
          <span class="truncate text-sm font-semibold text-foreground/90">{player.name ?? $locales.anonymous_player}</span>
        </div>
      {/each}
    </div>
  </div>
{/if}
