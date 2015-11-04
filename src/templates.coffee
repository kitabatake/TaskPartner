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

        <div class='card-memo-area'>
          <textarea class="form-control memo-content-input"></textarea>
          <button class="memo-add-btn btn btn-primary btn-sm">Add Memo</button>
        </div>

        <div class='memos'>
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
  <div class='memo-content'><%= content %></div>
</div>
"""