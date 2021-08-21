onPageLoad ['tasks#index', 'tasks#select_issue'], ->
  $("[name=check1]").each (index, element) ->
    element.addEventListener 'change', (e) => 
     # idを変数に格納、正規表現で数値を取り出し
     # ajaxでurlに式展開でurl指定
     myRe = /\d+/
     target_id = e.target.id
     task_id = myRe.exec(target_id)
     if element.checked
       ## 完了
       $.ajax
         type: "PUT"
         url: "/tasks/#{task_id[0]}/status_done"
     else
       ## 未完了
       $.ajax
         type: "PUT"
         url: "/tasks/#{task_id[0]}/status_run"

onPageLoad ['tasks#select_issue'], ->
  TaskNewModal = document.getElementById 'TaskNewModal'
  TaskNewModal.addEventListener 'show.bs.modal', (event) =>
    button = event.relatedTarget
    recipient = button.getAttribute 'data-bs-whatever'
    modalBodySelect = TaskNewModal.querySelector('.modal-body select')
    modalBodySelect.value = recipient
