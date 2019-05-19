package com.zxc.service.impl;

import com.zxc.model.Page;
import com.zxc.service.PageService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PageServiceImpl implements PageService {
    @Override
    public Page subList(int page, List list) {
        Page paging=new Page();
        paging.setCurrentPage(page);
        int count = list.size();
        paging.setTotalPage(count % 10 == 0 ? count / 10 : count / 10 + 1);
        paging.setPageSize(10);
        paging.setStar((paging.getCurrentPage() - 1) * paging.getPageSize());
        paging.setDataList(list.subList(paging.getStar(), count - paging.getStar() > paging.getPageSize() ? paging.getStar() + paging.getPageSize() : count));
        return paging;
    }
}
