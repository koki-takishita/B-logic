onPageLoad 'issues#select_goal', ->
  IssueNewModal = document.getElementById 'IssueNewModal'
  IssueNewModal.addEventListener 'show.bs.modal', (event) =>
    button = event.relatedTarget
    recipient = button.getAttribute 'data-bs-whatever'
    modalBodySelect = IssueNewModal.querySelector('.modal-body select')
    modalBodySelect.value = recipient

onPageLoad ['tasks#select_issue'], ->
  TaskNewModal = document.getElementById 'TaskNewModal'
  TaskNewModal.addEventListener 'show.bs.modal', (event) =>
    button = event.relatedTarget
    recipient = button.getAttribute 'data-bs-whatever'
    modalBodySelect = TaskNewModal.querySelector('.modal-body select')
    modalBodySelect.value = recipient
