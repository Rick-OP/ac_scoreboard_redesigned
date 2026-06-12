<script lang="ts">
  import { Tooltip as TooltipPrimitive } from 'bits-ui';
  import { cn } from '$utils/misc';
  import { flyAndScale } from './animation';

  type $$Props = TooltipPrimitive.ContentProps;

  let className: $$Props['class'] = undefined;
  export let sideOffset: $$Props['sideOffset'] = 4;
  export let transition: $$Props['transition'] = flyAndScale;
  export let transitionConfig: $$Props['transitionConfig'] = {
    y: 8,
    duration: 150,
  };
  export { className as class };
</script>

<TooltipPrimitive.Content
  {transition}
  {transitionConfig}
  {sideOffset}
  class={cn(
    'z-50 overflow-hidden rounded-xl bg-popover border border-border/50 px-3.5 py-2 text-xs text-popover-foreground',
    className
  )}
  {...$$restProps}
>
  <slot />
</TooltipPrimitive.Content>
