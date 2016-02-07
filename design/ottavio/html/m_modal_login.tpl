<div class="modal fade" id="modalLogin" tabindex="-1" role="dialog" aria-labelledby="modalLoginLabel" aria-hidden="true">
	<div class="modal-dialog modal-login">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="modalLoginLabel">Вход</h4>
			</div>
			
			<form id="modalLoginForm" method="post" class="validate">
				<div class="modal-body">
					<div class="form-group">
						<label for="modalLogin_email">Email</label>
						<input id="modalLogin_email" type="email" name="email" value="" class="form-control input-lg" required>
					</div>
				
					<div class="form-group">
						<label for="modalLogin_password">Пароль</label>
						<input id="modalLogin_password" type="password" name="password" value="" class="form-control input-lg" required>
					</div>
					
				
					<div class="form-inline form-group team-name text-center">
						<button type="submit" class="btn btn-primary">Войти</button>
					</div>

					<div id="modalLoginResult"></div>
					
					<div class="row">
						<div class="col-md-6">
							<a href="user/password_remind"><small>Забыли пароль?</small></a>
						</div>
						
						<div class="col-md-6">
							<a href="user/register" class="pull-right"><small><strong>Регистрация</strong></small></a>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>