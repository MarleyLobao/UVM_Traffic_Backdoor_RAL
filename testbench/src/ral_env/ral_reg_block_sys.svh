class ral_reg_block_sys extends uvm_reg_block;
  rand ral_reg_block_cfg cfg;

  `uvm_object_utils(ral_reg_block_sys)

  function new(string name = "ral_reg_block_sys");
    super.new(name);
  endfunction

	function void build();
    default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 0);
    cfg = ral_reg_block_cfg::type_id::create("cfg",,get_full_name());
    
    // Since registers exist at the DUT level in our design, configure
    // "cfg" class to have an HDL path called "my_traffic". So complete path to 
    // DUT is now "traffic_top.my_traffic"
    cfg.configure(this, "my_traffic");
    cfg.build();
    
    // Path to this top level regblock in our testbench environment is "traffic_top"
    add_hdl_path("traffic_top");
    default_map.add_submap(this.cfg.default_map, `UVM_REG_ADDR_WIDTH'h0);
	endfunction
endclass
