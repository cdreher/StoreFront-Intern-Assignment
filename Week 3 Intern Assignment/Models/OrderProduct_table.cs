//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Week_3_Intern_Assignment.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class OrderProduct_table
    {
        public int OrderProductID { get; set; }
        public int OrderID { get; set; }
        public int ProductID { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public System.DateTime DateCreated { get; set; }
        public string CreatedBy { get; set; }
        public System.DateTime DateModified { get; set; }
        public string ModifiedBy { get; set; }
    
        public virtual Order_table Order_table { get; set; }
        public virtual Product_table Product_table { get; set; }
    }
}
