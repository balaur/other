queue_size = ARGV[0] ? ARGV[0].to_i : 10000
arrival_rate = ARGV[1] ? ARGV[1].to_i : 3
number_of_servers = ARGV[2] ? ARGV[2].to_i : 2
execution_time = ARGV[3] ? ARGV[3].to_i : 25
sim_time = ARGV[4] ? ARGV[4].to_i : 1000000

servers = []
queue = 0
received_requests = 0
rejected_requests = 0
queue_average = 0
i = 0

# idle all servers
for i in (1..number_of_servers)
  servers[i] = 0
end

arrival_probablity = 1.to_f/arrival_rate.to_f 

for t in (1..sim_time)
  if rand() < arrival_probablity
    # new request
    received_requests = received_requests + 1

    # check queue size
    if queue < queue_size
      queue = queue + 1
    else
      # reject request if the queue is full
      rejected_requests = rejected_requests + 1
    end
  end

  # simulate the workers and the execution time on each
  for i in (1..number_of_servers)
    # decrease time
    servers[i] = servers[i] - 1 if servers[i] > 0
   
    # attach request on idle worker
    if servers[i] == 0 && queue > 0
      queue = queue - 1
      servers[i] = execution_time
    end
  end

  queue_average = queue_average + queue
end

queue_average = queue_average.to_f / sim_time

puts "Total requests " + received_requests.to_s
puts "Rejected requests " + rejected_requests.to_s
puts "Percentage of rejected requests " + (rejected_requests.to_f*100/received_requests).to_s + "%"
puts "Average Queue Size " + queue_average.to_s
