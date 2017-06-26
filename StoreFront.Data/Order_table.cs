//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StoreFront.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class Order_table
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Order_table()
        {
            this.OrderProduct_table = new HashSet<OrderProduct_table>();
        }
    
        public int OrderID { get; set; }
        public int UserID { get; set; }
        public int AddressID { get; set; }
        public System.DateTime OrderDate { get; set; }
        public decimal Total { get; set; }
        public int StatusID { get; set; }
        public System.DateTime DateCreated { get; set; }
        public string CreatedBy { get; set; }
        public System.DateTime DateModified { get; set; }
        public string ModifiedBy { get; set; }
    
        public virtual Address_table Address_table { get; set; }
        public virtual Status_table Status_table { get; set; }
        public virtual User_table User_table { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderProduct_table> OrderProduct_table { get; set; }
    }
}
