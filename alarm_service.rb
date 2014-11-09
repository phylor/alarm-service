get '/start' do
	if File.exist?('pid.txt')
		'Already running.'
	else
		pid = fork { exec './play_alarm.sh' }

		file = File.open('pid.txt', 'w')
		file.write pid
		file.close

		'ALARM.'
	end
end

get '/stop' do
	file = File.open('pid.txt', 'r')
	pid = file.readline
	pid = pid.to_i

	File.delete('pid.txt')

	Process.kill "KILL", pid
	Process.wait pid
end
