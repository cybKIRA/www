<nav id="main-navigation" class="navbar navbar-fixed-top navbar-standard">
	<a href="javascript:void(0)" class="search_button"><i class="fa fa-search"></i></a>
	
	<form action="products" role="search" class="h_search_form">
		<div class="container">
			<div class="h_search_form_wrapper">
				<div class="input-group"><span class="input-group-btn">
					<button type="submit" class="btn btn-sm"><i class="fa fa-search fa-lg"></i></button></span>
					<input id="search_input" type="text" name="keyword" value="{$keyword|escape}" placeholder="Поиск товара" class="form-control" autocomplete="off">
				</div>
				
				<div class="h_search_close"><a href="#"><i class="fa fa-times"></i></a></div>
			</div>
		</div>
	</form>

	<div class="container">
		
		<div class="navbar-header hidden-sm">
			<button type="button" class="navbar-toggle"><i class="fa fa-align-justify fa-lg"></i></button>
			
			<a href="./" class="navbar-brand">
				<img src="design/{$settings->theme}/images/logo-white.png" alt="{$settings->site_name|escape}" class="logo-trs">
				<img src="design/{$settings->theme}/images/logo-white.png" alt="{$settings->site_name|escape}" class="logo-white">
				<img src="design/{$settings->theme}/images/logo-dark.png" alt="{$settings->site_name|escape}" class="logo-dark">
			</a>
		</div>
		
		<div class="navbar-collapse collapse">
		
		
			<ul class="nav navbar-nav navbar-right service-nav">
			<li>
				<a href="tel:+74994040996" id="nav-phone">8 (499) 40 40 996</a>
				<small id="nav-phone-bottom">Звоните! пн-пт: с 11:00 до 20:00</small>
			</li>
				<li>
					{if $user}
						<a id="dropdownMenuLogin" href="#" data-toggle="dropdown" class="upper dropdown-toggle">Личный кабинет</a>
					
						<div aria-labelledby="dropdownMenuLogin" class="dropdown-menu widget-box">
							<ul class="user-menu">
								<li><h5>{$user->name}</h5></li>
								{if $group->discount>0}
								<li><i class="fa fa-tag"></i>Ваша скидка &mdash; {$group->discount}%</li>
								{/if}
								<li><a href="user"><i class="fa fa-list-alt"></i>Ваши заказы</a></li>
								<li><a href="user"><i class="fa fa-cog"></i>Настройки</a></li>
								<li class="separate"></li>
								<li><a href="user/logout"><i class="fa fa-sign-out"></i>Выйти</a></li>
							</ul>
						</div>
					{else}
						<a id="dropdownMenuLogin" href="#" data-toggle="dropdown" class="dropdown-toggle">Войти</a>
						
						<div aria-labelledby="dropdownMenuLogin" class="dropdown-menu widget-box">
							<form id="loginForm">
								<div class="form-group">
									<label class="sr-only">Email</label>
									<input type="text" value="" placeholder="Email" name="email" class="form-control input-lg">
								</div>
								
								<div class="form-group">
									<label class="sr-only">Пароль</label>
									<input type="password" value="" placeholder="Пароль" name="password" class="form-control input-lg">
								</div>
								
								<div class="form-inline form-group team-name">
									<button type="submit" class="btn btn-primary btn-xs">Войти</button>
								</div>
							</form>

							<div id="loginResult"></div>
							<a href="user/password_remind"><small>Забыли пароль?</small></a>
							<a href="user/register" class="pull-right"><small><strong>Регистрация</strong></small></a>
						</div>
					{/if}
				</li>
				
				<li>
					<a id="dropdownMenuCart" href="#" data-toggle="dropdown" class="dropdown-toggle"><i class="fa fa-shopping-cart fa-lg"></i>{if $cart->total_products > 0}&nbsp;<span class="badge">{$cart->total_products}</span>{/if}</a>
					
					<div id="cart_informer" class="dropdown-menu widget-box" aria-labelledby="dropdownMenuCart">
						{include file='cart_informer.tpl'}
					</div>
					
					<div id="cart_informer_notify">
						<div class="notify-arrow"></div>
						<div class="notify-content"></div>
					</div>
				</li>
				
				<li class="hidden">
					<a id="dropdownMenuCurrency" href="#" data-toggle="dropdown" class="upper dropdown-toggle">Валюта</a>
					
					<div aria-labelledby="dropdownMenuCurrency" class="dropdown-menu widget-box">
						{* Выбор валюты только если их больше одной *}
						{if $currencies|count>1}
						<div id="currencies">
							<h2></h2>
							<ul>
								{foreach from=$currencies item=c}
								{if $c->enabled} 
								<li class="{if $c->id==$currency->id}selected{/if}"><a href='{url currency_id=$c->id}'>{$c->name|escape}</a></li>
								{/if}
								{/foreach}
							</ul>
						</div> 
						{/if}
					</div>
				</li>
			</ul>
			
			<button type="button" class="navbar-toggle"><i class="fa fa-close fa-lg"></i></button>
			
			<ul class="nav yamm navbar-nav navbar-left main-nav">
			
			
                <!--
				<li class="dropdown">
					<a href="products" data-toggle="dropdown" data-hover="dropdown" id="menu_item_Catalog" data-ref="#" class="dropdown-toggle">Каталог<span class="caret"></span></a>

					{* Рекурсивная функция вывода дерева категорий *}
					{function name=categories_tree}
					{if $categories}
					<ul aria-labelledby="{if $c}menu_item_Catalog_{$c->id}{else}menu_item_Catalog{/if}" {if $c->subcategories || $c->parent_id == 0}class="dropdown-menu"{/if}>
					{foreach $categories as $c}
						{* Показываем только видимые категории *}
						{if $c->visible}
							<li {if $c->subcategories || $category->id == $c->id}class="{if $c->subcategories}dropdown-submenu{/if}{if $category->id == $c->id} active{/if}"{/if}>
								<a href="catalog/{$c->url}" title="{$c->name|escape}" {if $c->subcategories}id="menu_item_Catalog_{$c->id}"{/if} data-category="{$c->id}" data-ref="#">{$c->name|escape}</a>
								{if $c->subcategories}
									{categories_tree categories=$c->subcategories}
								{/if}
							</li>
						{/if}
					{/foreach}
					</ul>
					{/if}
					{/function}
					{categories_tree categories=$categories}
				</li>
			-->

             <li class="dropdown yamm-fw"><a href="#" title="Shop" data-toggle="dropdown" data-hover="dropdown" id="menu_item_Shop" data-ref="#" class="dropdown-toggle">Каталог<span class="caret"></span></a>
               <ul aria-labelledby="menu_item_Shop" class="dropdown-menu">
                <li>
                 <div class="yamm-content">
                  {if $categories}
                  {$iteration = 1}
                  <div class="row">
                   {foreach $categories as $c}
                   {if $c->visible}
                   <div class="col-md-3 col-sm-6">
                    <h6><a href="catalog/{$c->url}" class="primary" data-category="{$c->id}">{$c->name|escape}</a></h6>
					
					{$array_cat = array()}
					{$array_cat[] = $c->id}
					{if $c->subcategories}
						{foreach $c->subcategories as $c_sub}
						{$array_cat[] = $c_sub->id}
						{/foreach}
					{/if}
					
                    {if $c->subcategories && $c->id != 16 && $c->id != 17}					
                    <ul class="sep-top-xs sep-bottom-xs widget widget-cat">
                     {foreach $c->subcategories as $c_sub}
                      <li class="cat-item"><a href="catalog/{$c_sub->url}">{$c_sub->name|escape}</a></li>
                     {/foreach}
                    </ul>
                    {/if}
					
					{get_brands var=all_brands category_id=$array_cat}
					{if $all_brands && $c->id == 16 || $c->id == 17}
						<ul class="sep-top-xs sep-bottom-xs widget widget-cat">	
						{foreach $all_brands as $b}	
							<li class="cat-item"><a href="catalog/{$c->url}/{$b->url}">{$b->name|escape}</a></li>				
						{/foreach}
						</ul>
					{/if}					
					
                   </div>
                   {if $iteration is div by 4}</div><div class="row">{/if}

                   {$iteration = $iteration + 1}
                   {/if}
                   {/foreach}

                  </div>
                  {/if}
                 </div>
                </li>
				
               </ul>
              </li>

				{foreach $pages as $p}
					{* Выводим только страницы из первого меню *}
					{if $p->menu_id == 1}
					<li {if $page && $page->id == $p->id}class="active"{/if}>
						<a data-page="{$p->id}" href="{$p->url}">{$p->name|escape}</a>
					</li>
					{/if}
				{/foreach}
				
			</ul>
			
		</div>
		
	</div>
</nav>