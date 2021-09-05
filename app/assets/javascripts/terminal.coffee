# 変数定義
word = []
enter_flug = 0
flag = 0
h_objects = 0
invalid_keys = {
  Esc: 27,
  Tab: 9,
  Ctrl: 17,
  Shift: 16,
  CapsLock: 20,
  Alt: 18,
  Cmd_R: 91,
  Cmd_L: 93,
  Arrow_Left: 37,
  Arrow_Right: 39,
  Arrow_Up: 38,
  Arrow_Down: 40
}
open_files = [
  'goal_index.html',
  'issue_index.html',
  'task_index.html',
  # サービス紹介ページ
  'introduction.html',
  # 問い合わせ
  'contact.html',
  'terms_of_service.html'
  # プライポリシー
  'play_policies.html'
]
space = /^\s+$/
open = /^open\s*$/
open_name = /^open\s{1}([a-zA-z]+\.{1}[a-zA^z]+$)/
open_not_name = /^open\s{1}([a-zA-z]+)$/
open_arg_capture = /^open\s{1}(?<file>[a-zA-z]+)$/
open_arg = 0



not_used_key = (i_key) ->
  for value of invalid_keys
    # if
    #   ..
    # else
    #   ..
    # 上の形にすると動かなくなる
    # 三項演算子も動かなくなる
    return true if invalid_keys[value] == i_key.keyCode
    return false if !invalid_keys[value] == i_key.keyCode

word_delete = ->
  word.pop()
  return false

word_add_blank = (target) ->
  word.push "\u00a0"
  false

object_list = ->
  h_terminal = document.getElementById 'terminal'
  h_input_cmd = document.getElementById 'js-input-cmd'
  h_flickr = document.getElementById 'js-flickr'
  return object = [h_terminal, h_input_cmd, h_flickr]

prompt_delete = ->
  h_objects = object_list()
  for obj in h_objects
    obj.removeAttribute 'id'
  # '_' 削除
  h_objects[2].textContent = ''

add_element = ->
  # ターミナル用element作成
  new_terminal = document.createElement 'p'
  new_cmd = document.createElement 'strong'
  new_flickr = document.createElement 'strong'

  # 属性追加
  new_terminal.id = 'terminal'
  new_cmd.id = 'js-input-cmd'
  new_flickr.id = 'js-flickr'
  new_terminal.className = 'terminal-object-text-color m-0'
  new_terminal.textContent = '$ '
  new_flickr.textContent = '_'

  # 連結
  new_terminal.appendChild new_cmd
  new_terminal.appendChild new_flickr

  # 作成したelementを追加
  prompt_ele = document.getElementById 'prompt'
  prompt_ele.appendChild new_terminal

prompt_add = ->
  # create document
  add_element()

error_msg = ->
  prompt = document.getElementById 'prompt'
  # element作成
  new_error_msg = document.createElement 'p'
  # 属性付与
  new_error_msg.className='terminal-object-text-color m-0'
  new_error_msg.textContent = "error: #{word.join ''} command not found"
  # element追加
  prompt.appendChild new_error_msg

argument_msg = ->
  # element作成
  prompt = document.getElementById 'prompt'
  new_argument_msg = document.createElement 'p'
  new_argument_msg.className='terminal-object-text-color m-0'
 	new_argument_msg.textContent = 'usage: open [link_file]'
  # element追加
  prompt.appendChild new_argument_msg
  
arg_error = ->
  argument_msg()
  prompt_delete()
  prompt_add()
  word = []
  enter_flug = 1

screen_transition = (path) ->
  window.location.href = path

open_page = ->
  if open_arg[0] == 'goal_index.html'
    screen_transition('goals')
  else if open_arg[0] == 'issue_index.html'
    screen_transition('issues')
  else if open_arg[0] == 'task_index.html'
    screen_transition('tasks')
  else if open_arg[0] == 'contact.html'
    screen_transition('contacts/new')
  else if open_arg[0] == 'explanation.html'
    screen_transition('explanation')
  else if open_arg[0] == 'terms_of_service.html'
    screen_transition('t_of_s')
  else if open_arg[0] == 'play_policies.html'
    screen_transition('p_p')
  open_arg = 0

find_ary = (ary, object) ->
  for value in ary
    if object.match value
      open_arg =  object.match value
      return open_arg
    false

not_file = ->
  prompt = document.getElementById 'prompt'
  new_not_found = document.createElement 'p'
  new_not_found.className='terminal-object-text-color m-0'
 	new_not_found.textContent = "「#{open_arg[1]}」file not found"
  prompt.appendChild new_not_found

open_control = (cmd) ->
  open_file = ///#{find_ary(open_files, cmd)}///

  if open_arg = cmd.match open_file
    open_page()

  else if open_arg = (cmd.match open_not_name) || (cmd.match open_name)
    not_file()
    prompt_delete()
    prompt_add()
    word = []
    enter_flug = 1
    open_arg = 0
  else
    arg_error()

ls = ->
  files = []
  prompt = document.getElementById 'prompt'
  ls_msg = document.createElement 'p'
  ls_msg.className='terminal-object-text-color m-0'
  files.textContent ='goal_index.html'
  for value in open_files
    file = document.createElement 'p'
    file.className='m-0'
    file.textContent = value
    files.push file
  for value in files
    ls_msg.appendChild value
  prompt.appendChild ls_msg

help = ->
  console.log 'help'
  prompt = document.getElementById 'prompt'
  #prompt.className = 'w-100'
  help_msg = document.createElement 'ul'
  help_msg.className = 'terminal-object-text-color list-unstyled m-0'
  cmds = []
  cmd_list = {
    'open [link_file]:': 'open links',
    'ls:': 'list files',
    'clear:': 'delete the content'
  }
  # 配列複数取り出し、作成
  for value of cmd_list
    msg_li = document.createElement 'li'
    msg_dl = document.createElement 'dl'
    msg_dl.className = 'd-flex justify-content-between m-0'

    msg_label = document.createElement 'dt'
    msg_content = document.createElement 'dd'
    msg_label.className = 'w-50'
    msg_content.className = 'w-50'

    msg_label.textContent = value
    msg_content.textContent = cmd_list[value]

    msg_dl.appendChild msg_label
    msg_dl.appendChild msg_content
    msg_li.appendChild msg_dl
    cmds.push msg_li

  for value in cmds
    help_msg.appendChild value
  prompt.appendChild help_msg

# enter時はコマンド実行 別の処理
enter = (target) ->
  # 入力されたコマンド
  cmd = word.join ''
  # コマンド空白 or 未入力時
  if space.test(cmd) || cmd.length == 0
    # 改行して新たなプロンプト出現
    # id削除
    prompt_delete()
    # prompt追加
    prompt_add()
    word = []
  else if ((cmd.match open) || (cmd.match open_name) || (cmd.match open_not_name))
    open_control(cmd)
  else if cmd == 'clear'
    prompt = document.getElementById 'prompt'
    while prompt.lastChild
      prompt.removeChild prompt.lastChild
    add_element()
    word = []
  # 存在しないコマンド
  else if cmd == 'ls'
    ls()
    enter_flug = 1
    prompt_delete()
    prompt_add()
    word = []
  else if cmd == 'help'
    help()
    enter_flug = 1
    prompt_delete()
    prompt_add()
    word = []
  else
    enter_flug = 1
    target.innerHTML = word.join ''
    error_msg()
    prompt_delete()
    prompt_add()
    word = []

# 入力keyによって動作を制御
key_control = (i_key, target) ->
  # バグ対応 何故か読み込み時にi_keyがundefindとして発火してしまうため
  if i_key.keyCode == undefined
    false
  # enter key押したとき
  else if i_key.keyCode == 13
    enter(target)
    false
  # backspace押した時
  else if i_key.keyCode == 8
    # 入力文字削除
    word_delete()
  # space key押した時
  else if i_key.keyCode == 32
    # 空白文字追加処理
    word_add_blank target
  # 動作に関係ないkey押した時
  else if not_used_key i_key
    # 表示したくない無いkey排除
    false
  else
    true

flug_check = ->
  if enter_flug == 1
    enter_flug = 0
    return false
  else
    return true

input = ->
  word = []
  document.addEventListener 'keydown', (e) =>
    target = document.getElementById 'js-input-cmd'
    # true時入力されたkeyをwordの末尾に追加
    # word = []
    word.push e.key if key_control e, target
    # wordを画面に出力
    target.innerHTML = word.join '' if flug_check()
onPageLoad ['home#top', 'home#about'], ->
  word = []
  input()
