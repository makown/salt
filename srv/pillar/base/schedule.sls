schedule:
  job1:
    function: cmd.run
    args:
      - date >> /tmp/test.log
    minutes: 1
    
