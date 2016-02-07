<div class="sep-top-lg">
	<h5 class="">Выберите способ доставки</h5>
	<div class="sep-top-sm">
		<table class="table table-bordered table-condensed table-responsive">
			<tbody>
				{foreach $deliveries as $delivery}
				<tr>
					<td>
						<div class="radio text-left">
							<label for="deliveries_{$delivery->id}" {if ($delivery_id && $delivery_id==$delivery->id) || (!$delivery_id && $delivery@first)}class="active"{/if}>
								<div class="pull-right ">{if $cart->total_price < $delivery->free_from && $delivery->price>0}{$delivery->price|convert}&nbsp;{$currency->sign}{elseif $cart->total_price >= $delivery->free_from}бесплатно{/if}</div>
								
								<input type="radio" value="{$delivery->id}" name="delivery_id" id="deliveries_{$delivery->id}" {if ($delivery_id && $delivery_id==$delivery->id) || (!$delivery_id && $delivery@first)}checked{/if}>
								
								<strong class="dark">{$delivery->name}</strong>
							</label>
							
							
							{if $delivery->description}
							<div class="small sep-top-xs" {if ($delivery_id && $delivery_id!=$delivery->id) || (!$delivery_id && !$delivery@first)}style="display: none"{/if}>
								{$delivery->description}
							</div>
							{/if}
						</div>
					</td>
				</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
</div>