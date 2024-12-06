using Service.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Email
{
    public interface ITemplateFactory
    {
        (string Subject, string Body) GetTemplate(EmailDTO emailDTO);
    }
}
