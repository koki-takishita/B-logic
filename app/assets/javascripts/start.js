/*
          function draggable(target) {
            // ボタンをクリックしたときに発生
            target.onmousedown = function(e) {
              var a1 = document.getElementById('terminal');
              var b1 = document.getElementById('b1');
              a1.style.zIndex = 1;
              b1.style.zIndex = 1;
              target.style.zIndex = 999;
              // ボタンをクリック、クリックした上で対象をドラッグしたときに
              // onmousemoveイベントで座標を監視
              // 取得した座標をスタイルに上書きしていき位置を変化させている.
              var event = e ? e : window.event;
              x = event.pageX - target.offsetLeft;
              y = event.pageY - target.offsetTop;
              document.onmousemove = mouseMove;
              function mouseMove(e) {
                var event = e ? e : window.event;
                // 座標を代入
                target.style.top = event.pageY - y + 'px';
                target.style.left = event.pageX - x + 'px';
                target.style.zIndex = 999;
              }
              // ボタンを離したときに発生
              document.onmouseup = function() {
                document.onmousemove = null;
              }
            }
          }
         var flag = 0;
         function dip() {
              var target = document.getElementById('prompt');
              if(flag==0){
                  target.style.display ='none';
                  flag = 1;
                  console.log(flag);
                }
              else{
                  target.style.display ='inline';
                  flag = 0;
                  console.log(flag);
                }
              setTimeout('dip()', 300);
          }
  window.addEventListener('load', () => {
        // 点滅プログラム
          dip();
          // コマンド入力プログラム
          var params = { 'email': 0, 'password': 0, 'password_confirmation': 0};
          var word = [];
          var login_flag = 0;
                // 初期コンポーネント 名前がふさわしくない 使うのは一度切りだから addは使いまわせることを連想させる
                function new_prompt_add(){
                  // プロンプト部品 mackbook-pro
                  const mackbook_pro = document.createElement('p');
                  mackbook_pro.textContent = 'Mackbook-pro'
                  // $
                  const input_flicker = document.createElement('strong');
                  input_flicker.textContent ='_';
                  input_flicker.setAttribute('id', 'prompt');
                  // コマンド表示部分
                  const coment = document.createElement('strong');
                  coment.className='now_cmd';
                  // プロンプト部品 $ _
                  const input_label = document.createElement('p');
                  // プロンプト部品大枠作成
                  const text = document.createElement('div');
                  text.className=='text';
                  // 部品結合
                  input_label.textContent = '$ ';
                  input_label.appendChild(coment);
                  input_label.appendChild(input_flicker);
                  text.className ='text'
                  // 部品結合
                  text.appendChild(mackbook_pro);
                  text.appendChild(input_label);
  
                  // 結合
                  const prompt_box = document.getElementById('terminal');
                  prompt_box.appendChild(text);
                }
                function delete_element_byid(){
                        for (let i=0; i < arguments.length; i++){
                                let element = document.getElementById(arguments[i]);
                                element.remove();
                              }
                      }
                function delete_element_byclass(){
                         for (let i=0; i < arguments.length; i++){
                                 var elements = document.getElementsByClassName(arguments[i]);
                                 for (let i=0; i < elements.length; i++){
                                         let element = elements[i];
                                         element.remove();
                                       }
                              }
                      }
                function form_new({classname, label}){
                        // コンポーネント
                        let form_object = document.createElement('div');
                        let form_block = document.createElement('p');
                        let form_label = document.createElement('strong');
                        let form_cmd = document.createElement('strong');
                        let form_prompt = document.createElement('strong');
  
                        // id, classname指定
                        form_object.className = classname;
                        form_prompt.textContent = '_';
  
                        form_label.id = label;
                        form_prompt.id = 'prompt';
                        form_cmd.className = 'now_cmd';
  
                        // 表示するラベル名
                        form_label.textContent = label + ': ';
  
                        // コンポーネント合体
                        form_block.appendChild(form_label);
                        form_block.appendChild(form_cmd);
                        form_block.appendChild(form_prompt);
                        form_object.appendChild(form_block);
  
                        return form_object;
                      }
                function msg_new({classname, msg, label}){
                        // コンポーネント
                        let msg_object = document.createElement('div');
                        let msg_block = document.createElement('p');
                        // id, classname指定
                        msg_object.className = classname;
                        // 表示するコマンド名
                        msg_block.textContent = label + ': ' + msg;
                        // 表示
                        msg_object.appendChild(msg_block);
                        return msg_object
                      }
                function edge_element_byclass(classname){
                        // 指定したクラスの要素取得
                        let elements = document.getElementsByClassName(classname);
                        // 末尾の要素取得
                        return elements[elements.length - 1];
                      }
                function change_element_byclass({old_class, new_class}){
                        // 指定したクラスの要素取得
                        let elements = document.getElementsByClassName(old_class);
                        // 末尾の要素取得
                        let element = elements[elements.length - 1];
  
                        return element.className = new_class;
                      }
                function commonization(form){
                        const box = document.getElementById('terminal');
                        delete_element_byid('prompt');
                        change_element_byclass({old_class: 'now_cmd', new_class: 'then_cmd'});
                        // コンポーネント表示
                        box.appendChild(form);
                      }
  
            document.addEventListener('keydown', (e) => {
              console.log('keydown')
              //var target = document.getElementById('cmd');
              let now_cmd = edge_element_byclass('now_cmd');
                    // コマンド削除
                    if(e.key==='Backspace'){
                            console.log('削除')
                            word.pop();
                            let word_join = word.join('')
                            now_cmd.textContent = word_join;
                    }
                    // enter押した時の挙動
                    else if(e.key==='Enter'){
                            console.log('Enter')
                            // enter押した時点での入力情報を読み込む
                            let word_join = word.join('')
                            // [login] [user] のような[第一コマンド] [第２コマンド] を別々で条件分岐させるために空白でsplitさせる
                            let response = word_join.split(' ');
                            word = [];
                            const error_msg = document.createElement('p');
                            // login userと打った場合の処理
                            if(response[0]==='login'){
                                    console.log('login');
  
                                    // emailコンポーネント作成
                                    let login_email_form = form_new({classname: 'text', label: 'email'});
                                    // cmd prompt 削除
                                    commonization(login_email_form);
                                    // pramas初期化
                                    params['email'] = 0;
                                    params['password'] = 0;
                                    login_flag = 'email';
                            }
                            else if(login_flag==='email'){
                                    console.log('login_email');
                                    // 入力した内容を保持して表示
                                    params['email'] = word_join
  
                                    let login_password_form = form_new({classname: 'text', label: 'password'});
                                    commonization(login_password_form);
                                    login_flag='password';
  
                                    let email_login_form = document.getElementById('user_session_email');
                                    email_login_form.value = word_join;
                                  }
                            else if(login_flag==='password'){
                                    console.log('password');
                                    params['password'] = word_join;
                                    // ajax login 処理
                                    login_flag='ajax_login';
  
                                    let password_login_form = document.getElementById('user_session_password');
                                    password_login_form.value = word_join;
                                    document.getElementById('login_button').click(); 
  
                                    login_flag=0;
                                  }
                            else if(response[0]==='signup'){
                                    console.log('signup_email');
                                    let email_form = form_new({classname: 'text', label: 'email'});
                                    commonization(email_form);
                                    // pramas初期化
                                    params['email'] = 0;
                                    params['password'] = 0;
                                    params['password_confirmation'] = 0;
                                    login_flag='signup_password';
                                  }
                            else if(login_flag==='signup_password'){
                                    console.log('signup_password');
                                    let password_form = form_new({classname: 'text', label: 'password'});
                                    commonization(password_form);
                                    params['email'] = word_join;
  
                                    let email_signup_form = document.getElementById('user_email');
                                    email_signup_form.value = word_join;
  
                                    login_flag='signup_password_confirmation';
                                  }
                            else if(login_flag==='signup_password_confirmation'){
                                    console.log('signup_password_confirmation');
                                    let password_confirmation_form = form_new({classname: 'text', label: 'password_confirmation'});
                                    commonization(password_confirmation_form);
                                    params['password'] = word_join;
  
                                    let password_signup_form = document.getElementById('user_password');
                                    password_signup_form.value = word_join;
  
                                    login_flag='ajax_signup'
                                  }
                            else if(login_flag==='ajax_signup'){
                                    console.log('ajax_signup');
                                    params['password_confirmation'] = word_join;
  
                                    let password_confirmation_signup_form = document.getElementById('user_password_confirmation');
                                    password_confirmation_signup_form.value = word_join;
                                    document.getElementById('signup_button').click();
                                    login_flag=0;
                                  }
                            // clearコマンド実装
                            else if(response[0]==='clear'){
                                    console.log('clear');
                                    //delete_element_byclass('text');
                                    var contents = document.getElementsByClassName('text');
                                    var contents_list = Array.from(contents);
                                    contents_list.forEach(content => content.remove());
                                    new_prompt_add();
                                  }
                            // これがないと存在しないコマンドを打ったときの処理に入ってしまうため あえて何しない処理
                            else if(response[0]===''){
                                    console.log('空Enter');
                                    delete_element_byid('prompt');
                                    change_element_byclass({old_class: 'now_cmd', new_class: 'then_cmd'});
                                    // 毎回作成することで、上書きを防ぐ
                                    new_prompt_add();
                                  }
  
                            // 存在しないコマンドをうった時
                            else{
                                    console.log('not found');
                                    let error_msg = msg_new({classname: 'text', label: response[0], msg: 'command not found.'});
                                    commonization(error_msg);
                                    new_prompt_add();
                            }
                          }
                    else {
                            console.log('入力中');
                            // キーボード入力情報を配列の末尾に追加
                            word.push(e.key)
                            // 配列に格納されている入力情報結合
                            let word_join = word.join('')
                            // コマンド表示
                            now_cmd.textContent = word_join;
                                }
            });
        draggable(document.getElementById('terminal'));
        draggable(document.getElementById('b1'));
});
*/
