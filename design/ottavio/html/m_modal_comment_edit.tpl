<div class="modal fade" id="modalCommentEdit" tabindex="-1" role="dialog" aria-labelledby="modalCommentEditLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="modalCommentEditLabel">Мой отзыв о {$product->name}</h4>
			</div>
			
			<form method="post" class="validate">
				<div class="modal-body">
					<div class="form-group">
						<label for="modalCommentEdit_rating">Ваша оценка</label>
						<div class="rate">
							<input id="modalCommentEdit_rating" type="number" name="rate" value="{$user->comment->rate}" data-max="5" data-min="1" data-icon-lib="fa fa-lg" data-active-icon="fa-star" data-inactive-icon="fa-star-o" class="rating">
						</div>
					</div>
				
					<div class="form-group">
						<label for="modalCommentEdit_name">Имя</label>
						<input id="modalCommentEdit_name" type="text" name="name" value="{$user->comment->name|escape}" class="form-control input-lg" required>
					</div>
					
					<div class="form-group">
						<label for="modalCommentEdit_comment">Отзыв</label>
						<textarea id="modalCommentEdit_comment" rows="9" name="text" class="form-control input-lg" required>{$user->comment->text}</textarea>
					</div>
					
					<div class="form-group sep-top-xs text-right">
						<input type="hidden" name="comment_edit" value="input_for_submit_form">
						<button type="submit" class="btn btn-primary"><i class="fa fa-comment"></i>&nbsp;Отправить</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>