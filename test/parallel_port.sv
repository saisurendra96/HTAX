///////////////////////////////////////////////////////////////////////////
// Texas A&M University
// CSCE 616 Hardware Design Verification
// Created by  : Prof. Quinn and Saumil Gogri
///////////////////////////////////////////////////////////////////////////


class parallel_port extends base_test;

	`uvm_component_utils(parallel_port)

	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction : new

	function void build_phase(uvm_phase phase);
		uvm_config_wrapper::set(this,"tb.vsequencer.run_phase", "default_sequence", parallel_port_vsequence::type_id::get());
		super.build_phase(phase);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),"Starting parallel port test",UVM_NONE)
	endtask : run_phase

endclass : parallel_port



///////////////////////////// VIRTUAL SEQUENCE ///////////////////////////


class parallel_port_vsequence extends htax_base_vseq;

  `uvm_object_utils(parallel_port_vsequence)

  htax_packet_c req[5];
  rand int port, length;
  rand int i, j;

  function new (string name = "parallel_port_vsequence");
    super.new(name);
	for(int i=0; i<5; i++) begin
		req[i] = new();
	end
  endfunction : new

  task body();
		// Exectuing 10 TXNs on ports {0,1,2,3} randomly 
    repeat(1500) begin

      //port = $urandom_range(0,3);
      //i = $urandom_range(0,7);
	  //j = $urandom_range(0,7);
	  length = $urandom_range(3,10);
			 fork begin
			//USE `uvm_do_on_with to add constraints on req
			//`uvm_do_on(req, p_sequencer.htax_seqr[port])
			`uvm_do_on_with(req[0], p_sequencer.htax_seqr[0], {req[0].delay<=5; req[0].length <= 10;})
			end
			begin
			`uvm_do_on_with(req[1], p_sequencer.htax_seqr[1], {req[1].delay<=5; req[1].length <= 10;})
			end
			begin
			`uvm_do_on_with(req[2], p_sequencer.htax_seqr[2], {req[2].delay<=5; req[2].length <=10;})
			end
			begin
			`uvm_do_on_with(req[3], p_sequencer.htax_seqr[3], {req[3].delay<=5; req[3].length <=10;})
			end
			join
			//`uvm_do_on(req, p_sequencer.htax_seqr[port])
			//`uvm_do_on_with(req[7], p_sequencer.htax_seqr[3], {req[7].delay<=5; req[7].length == length;})
			//`uvm_do_on_with(req[6], p_sequencer.htax_seqr[2], {req[6].delay<=5; req[6].length== length;})
			//`uvm_do_on_with(req[5], p_sequencer.htax_seqr[1], {req[5].delay<=5; req[5].length== length;})
			`uvm_do_on_with(req[4], p_sequencer.htax_seqr[0], {req[4].delay<=5; req[4].length<=10;})
    end
    
  endtask : body

endclass : simple_random_vsequence
