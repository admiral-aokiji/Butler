WorkerScript.onMessage =(msg)=>{
    if (msg.action == 'appendItem'){ 
	msg.data.forEach((item)=>{
	    msg.model.append(item)
            msg.model.sync()
	})
    }
}
