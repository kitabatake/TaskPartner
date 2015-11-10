@Templates = {}

Templates.cardOutlineView = """
<div  class='card-outline'><%= title %></div>
"""

Templates.cardView = """
<div class="card modal" id='card-<%= id %>'>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="card-close close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><%= title %></h4>
      </div>
      <div class="modal-body">
        
        <div class='description-view-area clearfix'>
          <div class='card-description markdown-body'><%= descriptionMarked %></div>
          <button class="card-description-edit-btn btn btn-primary btn-sm">Edit Description</button>
        </div>

        <div class='description-edit-area clearfix' style='display: none;'>
          <textarea class="form-control card-description-input"><%= description %></textarea>
          <button class="card-description-save-btn btn btn-primary btn-sm">Save Description</button>
        </div>

        <div class='row' style='margin-top: 30px; padding: 20px 0 20px; background: #eee;'>
          <div class='col-md-5'>
            <div class='card-todo-area'>
              <div class='form-inline' style='margin-bottom: 20px;'>
                <input class="form-control todo-content-input" />
                <button class="todo-add-btn btn btn-primary btn-sm">Add Todo</button>
              </div>

              <div class='todos'>
              </div>
            </div>
          </div>

          <div class='col-md-7'>
            <div class='card-memo-area'>
              <textarea class="form-control memo-content-input"></textarea>
              <div style='text-align: center; margin-bottom: 20px;'>
                <button class="memo-add-btn btn btn-primary btn-sm">Add Memo</button>
              </div>
              <div class='memos'>
              </div>
            </div>
          </div>
        </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="card-delete-btn btn btn-warning">Delete</button>
        <button type="button" class="card-close btn btn-default">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
"""

Templates.memoView = """
<div class='memo'>
  <div class='memo-date'><%= created.fromNow() %></div>
  <div class='memo-content'><%= content %></div>
</div>
"""

Templates.todoView = """
<div class='todo'>
  <input class="toggle toggle-todo" type="checkbox" <%= done ? 'checked="checked"' : '' %> />
  <label class='todo-content'><%= content %></label>
</div>
"""