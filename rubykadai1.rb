require 'csv'

puts ""
puts "[ メモアプリ  ver.1.0 ]"
puts ""
puts "実行したい内容に該当する半角数字を入力し、Enterを押してください"
puts ""
puts "  1. メモを新規作成する    2. 保存済みのメモを編集する"
puts ""

choice = gets.to_s.chomp

puts ""
puts "  選択： 【 #{choice} 】"
puts ""

if choice == "1"
  puts "メモを新規作成します。"
  puts "ファイル名を入力してください。拡張子は自動的に付与されます。"
  puts ""
  
  file_name = gets.to_s.chomp
  
  puts ""
  puts "ファイル名 「 #{file_name} 」 でメモを新規作成します。"
  puts ""
  puts "メモする内容を入力してください。改行はEnterで反映されます。"
  puts "入力が完了したら、Ctrl/^control を押しながら D を押して下さい。"
  puts "-------------------------------------------------------"
  memo = STDIN.read
  puts "-------------------------------------------------------"
  
  CSV.open("#{file_name}.csv", "w") do |csv|
  csv.puts [memo]
  end
  
  puts "上記の入力内容を保存したメモファイル 「 #{file_name}.csv 」 が作成されました。"
  puts " "

elsif choice == "2"
  puts "保存済みのメモを編集します。"
  puts "編集するファイル名を入力してください。拡張子は不要です。"
  puts " "
  edit_file = gets.to_s.chomp
  puts " "

  begin
    CSV.read("#{edit_file}.csv")
  rescue
    puts "入力されたファイル名に誤りがある為、ファイルを読み込めません。"
    puts "処理を終了します。はじめからやり直してください。"
    puts " "
    return
  end
  
  puts "既存のメモファイル 「 #{edit_file}.csv 」 を編集します。"
  puts "編集するメモファイルの現在の内容を確認のため表示します。"
  puts "-------------------------------------------------------"
  puts CSV.read("#{edit_file}.csv")
  puts "-------------------------------------------------------"
  puts "このメモファイルを、どのように編集しますか？"
  puts "該当する半角数字を入力し、Enterを押してください"
  puts ""
  puts "  1. 末尾に追記する    2. 先頭から上書きする"
  puts ""
  
  editselect = gets.to_s.chomp
  
  puts ""
  puts "  選択： 【 #{editselect} 】"
  puts ""
  
  if editselect == "1"
    puts "現在のメモの末尾に追記します。"
    puts "追記する内容を入力してください。改行はEnterで反映されます。"
    puts "入力が完了したら、Ctrl/^control を押しながら D を押して下さい。"
    puts "-------------------------------------------------------"
    a_memo = STDIN.read
    puts "-------------------------------------------------------"
  
    CSV.open("#{edit_file}.csv", "a+") do |csv|
    csv.puts [a_memo]
    end
  
    puts " 「 #{edit_file}.csv 」 に上記の追記編集が完了しました。"
    puts " "
  
  elsif editselect == "2"
    puts "現在のメモの先頭から上書きします。現在のメモ内容は削除され、"
    puts "今から新しく入力するメモが上書きされますのでご注意ください。"
    puts "キャンセルする場合、Ctrl/^control を押しながら C を押して下さい。"
    puts "上書きを続行する場合は、内容を入力してください。改行はEnterで反映されます。"
    puts "入力が完了したら、Ctrl/^control を押しながら D を押して下さい。"
    puts "-------------------------------------------------------"
    w_memo = STDIN.read
    puts "-------------------------------------------------------"
  
    CSV.open("#{edit_file}.csv", "w+") do |csv|
    csv.puts [w_memo]
    end
  
    puts " 「 #{edit_file}.csv 」 に上記の上書き編集が完了しました。"
    puts " "
  
  else
    puts " 1 か 2 を半角で正しく入力して下さい。"
    puts " "
  end

else
  puts " 1 か 2 を半角で正しく入力して下さい。"
  puts " "
end
